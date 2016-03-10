class Slide < ActiveRecord::Base
  has_attached_file :picture, styles: { original:"1024x720", medium: "500x500>", thumb: "200x200>" }

  # on s'assure que le fichier envoyé sera de type 'image'
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  # On vérifie que le fichier aura l'extension 'png', 'jpg', 'jpeg'
  validates_attachment_file_name :picture, matches: [/png\Z/, /jpe?g\Z/]

  # On vérifie que l'image envoyé ne fasse pas plus d'un 1M
  validates_with AttachmentSizeValidator, attributes: :picture, less_than: 1.megabytes

  # on vérifie que les 4 champs seront bien rempli
  validates :name, :desc, :author, :picture, presence: true
  # on crée 2 scopes pour simplifier la synthaxe du controller
  # on recherche que les publication à 'true'
  scope :publication, -> {
     where(published: true)
   }
  # on cherche les publications dont la date du jour est comprise dans les dates de publication
  scope :min_publication, -> {
     where('DateTime(published_from) <= ? ', DateTime.now )
   }
  scope :max_publication, -> {
     where('DateTime(published_to) >= ?', DateTime.now )
   }
end
