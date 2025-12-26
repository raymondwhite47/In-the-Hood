const crypto = require('crypto');

const HEADER_SIGNATURE = 'x-signature';

const decodeBody = (event) => {
  if (!event.body) {
    return '';
  }

  if (event.isBase64Encoded) {
    return Buffer.from(event.body, 'base64').toString('utf-8');
  }

  return event.body;
};

const getHeader = (headers, name) => {
  if (!headers) {
    return undefined;
  }

  const direct = headers[name];
  if (direct) {
    return direct;
  }

  const match = Object.entries(headers).find(
    ([key]) => key.toLowerCase() === name.toLowerCase(),
  );

  return match ? match[1] : undefined;
};

const buildResponse = (statusCode, payload) => ({
  statusCode,
  headers: {
    'content-type': 'application/json',
  },
  body: JSON.stringify(payload),
});

const verifySignature = ({ rawBody, signature, secret }) => {
  if (!secret) {
    return { ok: true, reason: 'signature_not_required' };
  }

  if (!signature) {
    return { ok: false, reason: 'signature_missing' };
  }

  const expected = crypto
    .createHmac('sha256', secret)
    .update(rawBody, 'utf8')
    .digest('hex');

  const normalizedSignature = signature.replace(/^sha256=/, '');
  const isMatch = crypto.timingSafeEqual(
    Buffer.from(normalizedSignature, 'utf8'),
    Buffer.from(expected, 'utf8'),
  );

  return { ok: isMatch, reason: isMatch ? 'signature_valid' : 'signature_invalid' };
};

exports.handler = async (event) => {
  if (event.httpMethod && event.httpMethod.toUpperCase() !== 'POST') {
    return buildResponse(405, { message: 'Method Not Allowed' });
  }

  const rawBody = decodeBody(event);
  const secret = process.env.WEBHOOK_SECRET;
  const signature = getHeader(event.headers, HEADER_SIGNATURE);
  const verification = verifySignature({ rawBody, signature, secret });

  if (!verification.ok) {
    return buildResponse(401, { message: 'Unauthorized', reason: verification.reason });
  }

  let payload = null;
  try {
    payload = rawBody ? JSON.parse(rawBody) : null;
  } catch (error) {
    return buildResponse(400, { message: 'Invalid JSON payload' });
  }

  const eventType = getHeader(event.headers, 'x-webhook-event') || 'unknown';

  console.info('Webhook received', {
    eventType,
    hasPayload: Boolean(payload),
  });

  return buildResponse(200, {
    status: 'ok',
    receivedAt: new Date().toISOString(),
    eventType,
  });
};
