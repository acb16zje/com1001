# Methods used on control panel page #
def get_deal_name(id)
  @deals_db.execute(
    'SELECT name FROM deals WHERE deal_id = ?', id
  ).to_s.delete('[]"')
end

def get_deal_description(id)
  @deals_db.execute(
    'SELECT description FROM deals WHERE deal_id = ?', id
  ).to_s.delete('[]"')
end

def get_deal_discount(id)
  @deals_db.execute(
    'SELECT discount FROM deals WHERE deal_id = ?', id
  ).to_s.delete('[]"')
end

def get_deal_image_path(id)
  @deals_db.execute(
    'SELECT image_path FROM deals WHERE deal_id = ?', id
  ).to_s.delete('[]"')
end
