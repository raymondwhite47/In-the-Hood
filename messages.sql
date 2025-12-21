CREATE TABLE messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  neighborhood_id UUID NOT NULL REFERENCES neighborhoods(id),
  thread_id UUID NOT NULL REFERENCES message_threads(id),
  sender_user_id UUID NOT NULL REFERENCES users(id),

  body TEXT,
  -- optional attachment
  image_id UUID REFERENCES images(id),

  -- delivery state can be derived later; store minimal now
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_messages_neighborhood_created_at
  ON messages (neighborhood_id, created_at DESC)
  WHERE deleted_at IS NULL;

CREATE INDEX idx_messages_thread_created_at
  ON messages (thread_id, created_at ASC)
  WHERE deleted_at IS NULL;
