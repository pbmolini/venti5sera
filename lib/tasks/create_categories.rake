namespace :v5s do

  desc "Fill database with Categories"
  task create_categories: :environment do
    puts "== Creating Categories =="
    CATEGORIES = [
      'Principesse',
      'Gnomi',
      'Giovinotti',
      'Anni 80',
      'Anni 90',
      'Le maritate (da tempo)',
      'Scapoli',
      'Ammogliati',
      "Ne' belli ne' brutti",
      "Ne' giovani ne' vecchi",
      'Le grandi',
      'Le piccole',
      'Senza categoria'
    ]
    CATEGORIES.each do |category|
      unless Category.where(name: category).present?
        Category.create(name: category)
        puts "Category #{category} created"
      else
        puts "Category #{category} exists"
      end
    end
  end
end
