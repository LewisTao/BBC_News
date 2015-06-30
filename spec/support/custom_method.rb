def expect_hash_eq(hash1, hash2)
  expect_json_eq(hash1, hash2)
end

def expect_json_eq(obj1, obj2)
  expect(normalize_json(obj1)).to eq(normalize_json(obj2))
end

def normalize_json(obj)
  if obj.is_a?(Hash)
    obj = Hash[obj.sort_by{|k,v| k.to_s}]
  end

  obj.is_a?(String) ? obj : obj.to_json
end
