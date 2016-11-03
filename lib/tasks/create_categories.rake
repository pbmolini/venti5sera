namespace :v5s do

  desc "Fill database with Categories"
  task create_categories: :environment do
    puts "== Creating Categories =="
    CATEGORIES = {
      'Principesse' => 'magic',
      'Gnomi' => 'child',
      'Giovinotti' => 'headphones',
      'Anni 80' => 'gbp',
      'Anni 90' => 'eur',
      'Le maritate (da tempo)' => 'diamond',
      'Scapoli' => 'beer',
      'Ammogliati' => 'glass',
      "Ne' belli ne' brutti" => 'circle-o',
      "Ne' giovani ne' vecchi" => 'hourglass-half',
      'Le grandi' => 'chevron-right',
      'Le piccole' => 'chevron-left',
      'Senza categoria' => 'meh-o'
    }

    # Create the categories with name and icon
    CATEGORIES.each do |name, icon|
      unless Category.where(name: name).present?
        Category.create(name: name, icon: icon)
        puts "Category #{name} created"
      else
        puts "Category #{name} exists"
      end
    end

    # Assign last category to all users
    User.all.each do |user|
      user.category = Category.last
      user.save
    end
  end
end
