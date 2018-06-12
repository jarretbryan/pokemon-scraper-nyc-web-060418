ALTER TABLE pokemon
ADD hp INTEGER;

UPDATE pokemon SET hp = 60 WHERE hp = null;
