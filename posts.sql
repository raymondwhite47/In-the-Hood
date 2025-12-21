CREATE TABLE posts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  neighborhood_id UUID NOT NULL REFERENCES neighborhoods(id),
  author_user_id UUID NOT NULL REFERENCES users(id),

  type TEXT NOT NULL DEFAULT 'post', -- post|offer|request|event etc
  title TEXT,
  body TEXT,
  visibility TEXT NOT NULL DEFAULT 'neighborhood', -- neighborhood|thread|private
  status TEXT NOT NULL DEFAULT 'published', -- published|hidden|removed

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ
);

-- Required rule: index by neighborhood_id + created_at
CREATE INDEX idx_posts_neighborhood_created_at
  ON posts (neighborhood_id, created_at DESC)
  WHERE deleted_at IS NULL;

CREATE INDEX idx_posts_author_created_at
  ON posts (author_user_id, created_at DESC)
  WHERE deleted_at IS NULL;
