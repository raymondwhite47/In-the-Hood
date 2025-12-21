CREATE TABLE verification_jobs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  neighborhood_id UUID REFERENCES neighborhoods(id),
  user_id UUID REFERENCES users(id),

  job_type TEXT NOT NULL,              -- identity|address|post|image|other
  status TEXT NOT NULL DEFAULT 'queued', -- queued|running|passed|failed|canceled
  provider TEXT,                       -- e.g., persona|stripe|internal
  request_payload JSONB,
  result_payload JSONB,
  error_code TEXT,
  error_message TEXT,

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_verification_jobs_neighborhood_created_at
  ON verification_jobs (neighborhood_id, created_at DESC)
  WHERE deleted_at IS NULL AND neighborhood_id IS NOT NULL;

CREATE INDEX idx_verification_jobs_user_created_at
  ON verification_jobs (user_id, created_at DESC)
  WHERE deleted_at IS NULL AND user_id IS NOT NULL;

CREATE INDEX idx_verification_jobs_status_created_at
  ON verification_jobs (status, created_at DESC)
  WHERE deleted_at IS NULL;
