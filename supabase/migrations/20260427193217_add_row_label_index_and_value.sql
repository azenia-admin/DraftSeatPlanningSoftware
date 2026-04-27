/*
  # Add stable row label index and value columns

  1. Modified Tables
    - `furniture_items`
      - `row_label_index` (integer, nullable) - Stable index assigned when row labeling is enabled
      - `row_label_value` (text, nullable) - Pre-computed label string (e.g., "A", "B", "1", "2")

  2. Purpose
    - Row labels are now stored on the row at assignment time
    - Labels no longer shift when rows are moved on the grid
    - Each row keeps its assigned label regardless of position changes
*/

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'furniture_items' AND column_name = 'row_label_index'
  ) THEN
    ALTER TABLE furniture_items ADD COLUMN row_label_index integer;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'furniture_items' AND column_name = 'row_label_value'
  ) THEN
    ALTER TABLE furniture_items ADD COLUMN row_label_value text;
  END IF;
END $$;
