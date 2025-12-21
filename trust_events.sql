CREATE TABLE trust_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  neighborhood_id UUID REFERENCES neighborhoods(id),

  actor_user_id UUID REFERENCES users(id),
  subject_user_id UUID REFERENCES users(id),

  event_type TEXT NOT NULL, -- verification_passed|report_filed|report_upheld|ban|warning|message_sent|post_removed etc
  severity INT NOT NULL DEFAULT 0,
  source TEXT,              -- system|moderator|user|ml
  metadata JSONB,

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_trust_events_neighborhood_created_at
  ON trust_events (neighborhood_id, created_at DESC)
  WHERE deleted_at IS NULL AND neighborhood_id IS NOT NULL;

CREATE INDEX idx_trust_events_subject_created_at
  ON trust_events (subject_user_id, created_at DESC)
  WHERE deleted_at IS NULL AND subject_user_id IS NOT NULL;

CREATE INDEX idx_trust_events_type_created_at
  ON trust_events (event_type, created_at DESC)
  WHERE deleted_at IS NULL;
