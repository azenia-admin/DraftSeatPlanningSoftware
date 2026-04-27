/*
  # Fix row labeling defaults

  1. Changes
    - Change `row_label_enabled` default from `true` to `false` so new rows do not show labels by default
    - Change `row_label_position` default from `'auto'` to `'both'` since 'auto' is not a recognized position in rendering
    - Update existing rows with `row_label_position = 'auto'` to `'both'`
    - Update existing rows to set `row_label_enabled` to `false` (reset to new default)

  2. Notes
    - The 'auto' position value was never handled by the rendering logic, causing labels to not appear even when enabled
    - The recognized position values are: 'left', 'right', 'both', 'none'
    - Row labeling should be opt-in (disabled by default), not opt-out
*/

ALTER TABLE furniture_items
ALTER COLUMN row_label_enabled SET DEFAULT false;

ALTER TABLE furniture_items
ALTER COLUMN row_label_position SET DEFAULT 'both';

UPDATE furniture_items
SET row_label_position = 'both'
WHERE row_label_position = 'auto';

UPDATE furniture_items
SET row_label_enabled = false
WHERE type = 'row' AND row_label_enabled = true;
