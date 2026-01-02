const AWS = require('aws-sdk');

const dynamoDb = new AWS.DynamoDB.DocumentClient();
const tableName = process.env.TABLE_NAME;

const buildResponse = (statusCode, body) => ({
  statusCode,
  headers: {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': '*',
  },
  body: JSON.stringify(body),
});

const parseBody = (event) => {
  if (!event.body) {
    return {};
  }

  if (typeof event.body === 'object') {
    return event.body;
  }

  try {
    return JSON.parse(event.body);
  } catch (error) {
    return {};
  }
};

const createAuction = async (event) => {
  const payload = parseBody(event);

  if (!payload.id) {
    return buildResponse(400, { message: 'Auction id is required.' });
  }

  const params = {
    TableName: tableName,
    Item: payload,
  };

  await dynamoDb.put(params).promise();

  return buildResponse(201, payload);
};

const listAuctions = async () => {
  const params = {
    TableName: tableName,
  };

  const result = await dynamoDb.scan(params).promise();

  return buildResponse(200, result.Items ?? []);
};

const getAuction = async (event) => {
  const id = event.pathParameters?.id;

  if (!id) {
    return buildResponse(400, { message: 'Auction id is required.' });
  }

  const params = {
    TableName: tableName,
    Key: { id },
  };

  const result = await dynamoDb.get(params).promise();

  if (!result.Item) {
    return buildResponse(404, { message: 'Auction not found.' });
  }

  return buildResponse(200, result.Item);
};

const updateAuction = async (event) => {
  const id = event.pathParameters?.id;
  const payload = parseBody(event);

  if (!id) {
    return buildResponse(400, { message: 'Auction id is required.' });
  }

  if (Object.keys(payload).length === 0) {
    return buildResponse(400, { message: 'Update payload is required.' });
  }

  const expressionAttributeNames = {};
  const expressionAttributeValues = {};
  const updateExpressions = [];

  Object.entries(payload).forEach(([key, value], index) => {
    if (key === 'id') {
      return;
    }

    const attributeName = `#field${index}`;
    const attributeValue = `:value${index}`;

    expressionAttributeNames[attributeName] = key;
    expressionAttributeValues[attributeValue] = value;
    updateExpressions.push(`${attributeName} = ${attributeValue}`);
  });

  if (updateExpressions.length === 0) {
    return buildResponse(400, { message: 'Update payload must include fields to update.' });
  }

  const params = {
    TableName: tableName,
    Key: { id },
    UpdateExpression: `SET ${updateExpressions.join(', ')}`,
    ExpressionAttributeNames: expressionAttributeNames,
    ExpressionAttributeValues: expressionAttributeValues,
    ReturnValues: 'ALL_NEW',
  };

  const result = await dynamoDb.update(params).promise();

  return buildResponse(200, result.Attributes);
};

const deleteAuction = async (event) => {
  const id = event.pathParameters?.id;

  if (!id) {
    return buildResponse(400, { message: 'Auction id is required.' });
  }

  const params = {
    TableName: tableName,
    Key: { id },
  };

  await dynamoDb.delete(params).promise();

  return buildResponse(204, {});
};

exports.handler = async (event) => {
  console.log('Received event:', JSON.stringify(event));

  try {
    switch (event.httpMethod) {
      case 'GET':
        if (event.pathParameters?.id) {
          return await getAuction(event);
        }
        return await listAuctions();
      case 'POST':
        return await createAuction(event);
      case 'PUT':
      case 'PATCH':
        return await updateAuction(event);
      case 'DELETE':
        return await deleteAuction(event);
      default:
        return buildResponse(405, { message: 'Method not allowed.' });
    }
  } catch (error) {
    console.error('Error processing request:', error);
    return buildResponse(500, { message: 'Internal server error.' });
  }
};
