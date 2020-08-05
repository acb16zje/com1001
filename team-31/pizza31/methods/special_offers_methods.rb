# Method to be used in control panel (special offers)
def get_special_offer_code(id)
  @special_db.execute(
    'SELECT code FROM codes WHERE code_id = ?', id
  ).to_s.delete('[]"')
end

def get_special_offer_description(id)
  @special_db.execute(
    'SELECT description FROM codes WHERE code_id = ?', id
  ).to_s.delete('[]"')
end

def get_special_offer_discount(id)
  @special_db.execute(
    'SELECT discount FROM codes WHERE code_id = ?', id
  ).to_s.delete('[]"').to_f
end

def get_special_offer_used(id)
  used = @special_db.execute(
    'SELECT used FROM codes WHERE code_id = ?', id
  ).to_s.delete('[]"')
end

def get_special_offer_username(id)
  @special_db.execute(
    'SELECT username FROM codes WHERE code_id = ?', id
  ).to_s.delete('[]"')
end
