CREATE TABLE deals (
  deal_id     INTEGER NOT NULL PRIMARY KEY,
  name        TEXT    NOT NULL,
  description TEXT    NOT NULL,
  discount    FLOAT   NOT NULL,
  image_path  TEXT    NOT NULL,
  UNIQUE (NAME, DESCRIPTION)
);

INSERT INTO deals (deal_id, name, description, discount, image_path) VALUES
  (1, 'Over &pound40?',
   'Get an automatic 15% discount on your final price if you spend &pound40 or more',
   0.85, '/images/deals/deal-1.png'),
  (2, 'Go Large', 'For every two Large pizzas you order, get the third one completely free',
   1, '/images/deals/deal-2.png'),
  (3, 'Pepsi Lover', 'For every two Medium pizzas you order, get a free 2L Pepsi bottle',
   1, '/images/deals/deal-3.png');
