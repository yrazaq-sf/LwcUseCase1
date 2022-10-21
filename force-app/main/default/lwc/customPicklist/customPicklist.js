/**
 * Created by yrazaq on 11/10/2022.
 */

import {api, LightningElement} from 'lwc';

export default class CustomPicklist extends LightningElement {
    @api isrequired = false
    NoneOption = { label:"--None--", isSelected:true}
    selectedOption = this.NoneOption
    isOpen = false
    _options
    @api optionsArray // array contains all options in string format
    connectedCallback() {
        let _options = []
        if (this.optionsArray) {
            this.optionsArray.forEach(optionLabel => _options.push({label: optionLabel, isSelected:false}))
        }
        this._options = [this.NoneOption].concat(_options)
    }
    @api
    get options(){
        return this._options
    }
    set options(newOptions){
            this._options = newOptions
    }


    handlePicklistClick() {
        try {
            // open or close the picklist
            if (!this.isOpen) {
                this.isOpen = true
                this.template.querySelector('[data-id="picklist-selector"]').classList.add('slds-is-open')

            } else {
                this.isOpen = false
                this.template.querySelector('[data-id="picklist-selector"]').classList.remove('slds-is-open')
            }
        } catch (e) {
            console.error(e)
        }

    }

    handleOptionClicked(event) {
        // #######################################################################
        // ## 1- Change the option.isSelected to true for the selected picklist ##
        // ## 2- Add the error outline if None is seleceted                     ##
        // #######################################################################
        // 1- Changing the option.isSelected to true for the selected picklist
        let _options = []
        this.options.forEach((option)=> {
            let __option = {}
            __option.label =option.label;
            __option.isSelected = false;
            if(option.label === event.target.dataset.optionLabel){
                __option.isSelected = true
                this.selectedOption = __option
            }
            _options.push(__option)
        })
        this.options = _options
        // 2- Adding error outline if None is selected
        if (this.isrequired) {
            if (this.selectedOption.label === this.NoneOption.label) {
                this.template.querySelector('[data-id="picklist-button"]').classList.add('slds-has-error')
            } else {
                this.template.querySelector('[data-id="picklist-button"]').classList.remove('slds-has-error')
            }
        }
    }

    }