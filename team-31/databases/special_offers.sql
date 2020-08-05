CREATE TABLE codes (
  code_id     INTEGER NOT NULL PRIMARY KEY,
  code        TEXT    NOT NULL,
  description TEXT    NOT NULL,
  discount    FLOAT   NOT NULL,
  used        TEXT    NOT NULL,
  username    TEXT    NOT NULL,
  UNIQUE (code_id, code)
);

INSERT INTO codes (code_id, code, description, discount, used, username) VALUES
  (1, 'PIZZA31', '10% Off', 0.9, '', 'all');
