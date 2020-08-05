# Error handling pages #

# Login failure
get '/auth/failure' do
  erb :'error_handling/auth_failure'
end

# Invalid page
not_found do
  erb :'error_handling/not_found'
end

# Databases errors, code errors
error do
  erb :'error_handling/error'
end
