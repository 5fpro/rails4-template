json.array! @users do |uu|
  json.partial! 'user', u: uu
end

json.array! @users, partial: 'user', as: :u
