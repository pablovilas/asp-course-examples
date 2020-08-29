# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Organization.count == 0 
    petstore = Organization.create! name: "Petstore"
    toys = Organization.create! name: "Toys"

    petStoreComponents = ['iOS App', 'Android App', 'Backoffice', 'Orders service', 'Stock service']
    toysComponents = ['Web App', 'Backoffice', 'Orders service', 'Stock service', 'Payments service']

    petStoreComponents.each do |component|
        Component.create! organization: petstore, name: component, description: "#{component} component for #{petstore.name}"
    end

    toysComponents.each do |component|
        Component.create! organization: toys, name: component, description: "#{component} component for #{toys.name}"
    end

    (1..5).each do |subscriberId|
        Subscriber.create! name: "Subscriber ##{subscriberId}", email: "example#{subscriberId}@mail.com", components: [Component.where(organization_id: Organization.first.id).first]
    end

    #Incident.create! name: "Uuups!", status: "investigating", message: "Problems in petstore!", components: [Component.where(organization_id: Organization.first.id).first], organization: Organization.first
end