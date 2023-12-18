extends Control

var shape_material = preload("res://shape_texture.tres")

signal change_time

#region onreadys
@onready var metallic_box = $MarginContainer/TabContainer/Material/VBoxContainer/Metallic/CheckBox
@onready var metallic_slider = $MarginContainer/TabContainer/Material/VBoxContainer/Metallic/HSlider
@onready var roughness_box = $MarginContainer/TabContainer/Material/VBoxContainer/Roughness/CheckBox
@onready var roughness_slider = $MarginContainer/TabContainer/Material/VBoxContainer/Roughness/HSlider
@onready var reset_button = $MarginContainer/TabContainer/Material/VBoxContainer/ResetButton

@onready var emission_box = $MarginContainer/TabContainer/Emission/VBoxContainer/Enabled/CheckBox
@onready var emission_slider = $MarginContainer/TabContainer/Emission/VBoxContainer/Enabled/HSlider

@onready var color_picker = $MarginContainer/TabContainer/Color/ScrollContainer/MarginContainer/ColorPicker

@onready var billboard_box = $MarginContainer/TabContainer/funnies/VBoxContainer/Billboard/CheckBox
@onready var orthagraphic_box = $MarginContainer/TabContainer/funnies/VBoxContainer/Orthagraphic/CheckBox

@onready var switch = $MarginContainer/TabContainer/Illumination/VBoxContainer/Sky/switch
#endregion

func _process(_delta):
	
#region material
	if metallic_box.button_pressed:
		shape_material.metallic = metallic_slider.value
		metallic_slider.editable = true
	elif !metallic_box.button_pressed:
		shape_material.metallic = 0
		metallic_slider.editable = false
	
	if roughness_box.button_pressed:
		shape_material.roughness = roughness_slider.value
		roughness_slider.editable = true
	elif !roughness_box.button_pressed:
		shape_material.roughness = 1
		roughness_slider.editable = false
	
#endregion

#region emission
	if emission_box.button_pressed:
		shape_material.emission_energy_multiplier = emission_slider.value
		emission_slider.editable = true
		shape_material.emission_enabled = true
		shape_material.emission = shape_material.albedo_color
	elif !emission_box.button_pressed:
		emission_slider.editable = false
		shape_material.emission_enabled = false
		shape_material.emission_energy_multiplier = 0
#endregion
	
	shape_material.albedo_color = color_picker.color #color

#region funnies
	if billboard_box.button_pressed:
		shape_material.billboard_mode = BaseMaterial3D.BILLBOARD_ENABLED
	elif !billboard_box.button_pressed:
		shape_material.billboard_mode = BaseMaterial3D.BILLBOARD_DISABLED
		
	if orthagraphic_box.button_pressed:
		shape_material.fixed_size = true
	elif !orthagraphic_box.button_pressed:
		shape_material.fixed_size = false
#endregion

func _ready():
	switch.pressed.connect(func():
		emit_signal("change_time")	
	)
	reset_button.pressed.connect(func():
		metallic_slider.value = 0
		roughness_slider.value = 1
		emission_box.button_pressed = false
		emission_slider.value = 1
		color_picker.color = Color.GRAY
		billboard_box.button_pressed = false
		orthagraphic_box.button_pressed = false
	)

