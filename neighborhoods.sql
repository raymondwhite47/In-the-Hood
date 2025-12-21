CREATE TABLE neighborhoods (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  city TEXT,
  region TEXT,
  country TEXT,

  -- Prefer polygon for real boundaries; point+radius if you’re early.
  boundary GEOMETRY(MULTIPOLYGON, 4326),
  centroid GEOMETRY(POINT, 4326),

  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ
);

-- Geo indexes
CREATE INDEX idx_neighborhoods_boundary_gix ON neighborhoods USING GIST (boundary) WHERE deleted_at IS NULL;
CREATE INDEX idx_neighborhoods_centroid_gix ON neighborhoods USING GIST (centroid) WHERE deleted_at IS NULL;

CREATE INDEX idx_neighborhoods_created_at ON neighborhoods (created_at DESC) WHERE deleted_at IS NULL;
