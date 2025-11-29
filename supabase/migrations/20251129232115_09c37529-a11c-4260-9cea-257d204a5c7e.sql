-- Add reservation_code and room_code columns to reservations table
ALTER TABLE public.reservations 
ADD COLUMN IF NOT EXISTS reservation_code text,
ADD COLUMN IF NOT EXISTS room_code text;

-- Update existing reservations with generated codes
UPDATE public.reservations 
SET 
  reservation_code = 'RD' || upper(substring(md5(random()::text) from 1 for 6)),
  room_code = (1000 + floor(random() * 9000))::text
WHERE reservation_code IS NULL OR room_code IS NULL;