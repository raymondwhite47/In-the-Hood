CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email CITEXT UNIQUE,
  phone_e164 TEXT UNIQUE,
  display_name TEXT,
  avatar_image_id UUID,
  status TEXT NOT NULL DEFAULT 'active', -- active|disabled|banned
  last_seen_at TIMESTAMPTZ,

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_users_created_at ON users (created_at DESC) WHERE deleted_at IS NULL;
