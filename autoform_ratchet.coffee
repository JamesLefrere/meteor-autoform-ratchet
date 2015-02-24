#
# * Template helpers for "ratchet" template
#
Template["quickForm_ratchet"].helpers submitButtonAtts: ratchetQuickFormSubmitButtonAtts = ->
 qfAtts = @atts
 atts = {}
 if typeof qfAtts.buttonClasses is "string"
   atts["class"] = qfAtts.buttonClasses
 else
   atts["class"] = "btn btn-block btn-positive"
 atts

Template["afFormGroup_ratchet"].helpers
	skipLabel: ratchetFormGroupSkipLabel = ->
		self = this
		type = AutoForm.getInputType(self.afFieldInputAtts)
		self.skipLabel or type is "boolean-checkbox" or self.afFieldInputAtts.skipLabel

	ratchetfieldLabelAtts: ratchetFieldLabelAtts = ->
		atts = _.clone(@afFieldLabelAtts)

		# Add ratchet class
		atts = AutoForm.Utility.addClass(atts, "item-title label")
		atts

# _.each [
# 	"afSelect_ratchet"
# 	"afBooleanSelect_ratchet"
# 	"afSelectMultiple_ratchet"
# 	"afTextarea_ratchet"
# 	"afInputText_ratchet"
# 	"afInputPassword_ratchet"
# 	"afInputDateTime_ratchet"
# 	"afInputDateTimeLocal_ratchet"
# 	"afInputDate_ratchet"
# 	"afInputMonth_ratchet"
# 	"afInputTime_ratchet"
# 	"afInputWeek_ratchet"
# 	"afInputNumber_ratchet"
# 	"afInputEmail_ratchet"
# 	"afInputUrl_ratchet"
# 	"afInputSearch_ratchet"
# 	"afInputTel_ratchet"
# 	"afInputColor_ratchet"
# ], (tmplName) ->
# 	Template[tmplName].helpers atts: addFormControlAtts = ->
# 		atts = _.clone(@atts)
# 		# Add ratchet class
# 		atts = AutoForm.Utility.addClass(atts, "item-input")
# 		atts
#		return

# _.each [
# 	"afInputButton_ratchet"
# 	"afInputSubmit_ratchet"
# 	"afInputReset_ratchet"
# ], (tmplName) ->
# 	Template[tmplName].helpers atts: addFormControlAtts = ->
# 		atts = _.clone(@atts)
# 		# Add ratchet class
# 		atts = AutoForm.Utility.addClass(atts, "button")
# 		atts
# 	return

Template["afRadio_ratchet"].helpers atts: selectedAttsAdjust = ->
	atts = _.clone(@atts)
	atts.checked = ""  if @selected
	atts

_.each [
	"afCheckboxGroup_ratchet"
	"afRadioGroup_ratchet"
	"afCheckboxGroupInline_ratchet"
	"afRadioGroupInline_ratchet"
], (tmplName) ->
	Template[tmplName].helpers
		atts: selectedAttsAdjust = ->
			atts = _.clone(@atts)
			atts.checked = ""  if @selected

			# remove data-schema-key attribute because we put it
			# on the entire group
			delete atts["data-schema-key"]

			# atts = AutoForm.Utility.addClass(atts, "item-content")
			atts

		dsk: dsk = ->
			"data-schema-key": @atts["data-schema-key"]

	return

selectHelpers = optionAtts: afSelectOptionAtts = ->
	item = this
	atts = value: item.value
	atts.selected = ""  if item.selected
	atts

Template["afSelect_ratchet"].helpers selectHelpers
Template["afSelectMultiple_ratchet"].helpers selectHelpers
Template["afBooleanSelect_ratchet"].helpers selectHelpers
Template["afBooleanRadioGroup_ratchet"].helpers
	falseAtts: falseAtts = ->
		atts = _.omit(@atts, "trueLabel", "falseLabel", "data-schema-key")
		atts.checked = ""  if @value is false
		atts

	trueAtts: trueAtts = ->
		atts = _.omit(@atts, "trueLabel", "falseLabel", "data-schema-key")
		atts.checked = ""  if @value is true
		atts

	dsk: ->
		"data-schema-key": @atts["data-schema-key"]

AutoForm.setDefaultTemplate "ratchet"

Template.afFormGroup_ratchet.events
	"click .item-title": (e) ->
		if @afFieldInputAtts.description
			description = if typeof @afFieldInputAtts.description is "function" then @afFieldInputAtts.description() else @afFieldInputAtts.description
			RK.helpers.showPopover(e.currentTarget, description)
