# Arquitectura de Software en la Práctica

## Caching en rails

### Objetivos

El objetivo de este práctico es realizar una aplicación de ejemplo con caching que sirva como punto de partida para utilizar a lo largo del curso.

### Procedimiento

Crear el proyecto y los scaffold para *company* y *employee*

````
rails new phone-book
rails generate scaffold company name
rails generate scaffold employee company:references last_name first_name phone_number
rails db:migrate
````

Agregar las validaciones a los modelos

````
class Company < ApplicationRecord
  
  validates :name, presence: true, uniqueness: true
  has_many :employees, dependent: :destroy
  
  def to_s
    name
  end
  
end

class Employee < ApplicationRecord
  
  belongs_to :company, touch: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :company, presence: true
  
  def to_s
    “#{first_name} #{last_name}”
  end
  
end
````
