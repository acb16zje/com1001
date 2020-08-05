CREATE TABLE basket (
  item_id  INTEGER NOT NULL,
  pizza_id INTEGER NOT NULL,
  size     TEXT    NOT NULL,
  quantity INTEGER NOT NULL,
  username TEXT    NOT NULL,
  UNIQUE (item_id, pizza_id)
);

CREATE TABLE temp_basket (
  order_id INTEGER NOT NULL,
  item_id  INTEGER NOT NULL,
  pizza_id INTEGER NOT NULL,
  size     TEXT    NOT NULL,
  quantity INTEGER NOT NULL,
  username TEXT    NOT NULL,
  UNIQUE (order_id, item_id)
);

CREATE TABLE orders (
  order_id       INTEGER NOT NULL PRIMARY KEY,
  username       TEXT    NOT NULL,
  order_info     TEXT    NOT NULL,
  order_date     TEXT    NOT NULL,
  order_tweet_id TEXT    NOT NULL,
  total_price    FLOAT   NOT NULL,
  UNIQUE (order_id, username)
);

CREATE TABLE order_type (
  order_id   INTEGER NOT NULL REFERENCES orders (order_id),
  order_type TEXT    NOT NULL,
  PRIMARY KEY (order_id, order_type)
);

CREATE TABLE order_location (
  order_id INTEGER NOT NULL REFERENCES orders (order_id),
  location TEXT    NOT NULL,
  PRIMARY KEY (order_id, location)
);

CREATE TABLE order_day_amount (
  day_name TEXT    NOT NULL,
  amount   INTEGER NOT NULL,
  location TEXT    NOT NULL
);

CREATE TABLE order_status (
  order_id     INTEGER NOT NULL REFERENCES orders (order_id),
  order_status TEXT    NOT NULL,
  PRIMARY KEY (order_id, order_status)
);

INSERT INTO order_day_amount (day_name, amount, location) VALUES
  ('Monday', 0, 'Sheffield'),
  ('Monday', 0, 'London'),
  ('Tuesday', 0, 'Sheffield'),
  ('Tuesday', 0, 'London'),
  ('Wednesday', 0, 'Sheffield'),
  ('Wednesday', 0, 'London'),
  ('Thursday', 0, 'Sheffield'),
  ('Thursday', 0, 'London'),
  ('Friday', 0, 'Sheffield'),
  ('Friday', 0, 'London'),
  ('Saturday', 0, 'Sheffield'),
  ('Saturday', 0, 'London'),
  ('Sunday', 0, 'Sheffield'),
  ('Sunday', 0, 'London');
