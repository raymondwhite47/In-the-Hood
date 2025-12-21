CREATE TABLE images (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  uploader_user_id UUID NOT NULL REFERENCES users(id),

  -- Store pointer to object storage
  storage_key TEXT NOT NULL,
  content_type TEXT,
  byte_size BIGINT,
  width INT,
  height INT,

  -- Optional linkage (keep it flexible to avoid rewrites)
  neighborhood_id UUID REFERENCES neighborhoods(id),
  post_id UUID REFERENCES posts(id),

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_images_neighborhood_created_at
  ON images (neighborhood_id, created_at DESC)
  WHERE deleted_at IS NULL AND neighborhood_id IS NOT NULL;

CREATE INDEX idx_images_post_created_at
  ON images (post_id, created_at DESC)
  WHERE deleted_at IS NULL AND post_id IS NOT NULL;
