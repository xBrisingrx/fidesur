json.data @apples do |a|
	json.code a.code
	json.hectares a.hectares
	json.location a.location
	json.value "$ #{a.value}"
	json.sector a.sector.name
	json.actions "#{link_to '<i class="hs-admin-pencil"></i>'.html_safe, edit_apple_path(a), 
  								 :remote => true, 'data-toggle' =>  'modal',
      							'data-target' => '#modal-apple', 
      							'class' => 'u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12', title: 'Editar'}
  							<a class='u-link-v5 g-color-gray-light-v6 g-color-secondary--hover g-text-underline--none--hover g-ml-12' 
  								title='Eliminar' 
  								onclick='modal_disable_apple( #{ a.id } )'>
									<i class='hs-admin-trash' aria-hidden='true'></i></a>"
end