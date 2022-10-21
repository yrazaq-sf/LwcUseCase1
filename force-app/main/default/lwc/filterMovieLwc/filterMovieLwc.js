/**
 * Created by yrazaq on 2/10/2022.
 */

import {api, LightningElement} from 'lwc';

export default class FilterMovieLwc extends LightningElement {
    @api allMovies;
    @api categories;
    _searchText = '';
    _selectedCategory = '';
    allCategories = 'All';

    handleSearchChange(event) {
        this._searchText = event.target.value
        this._filterMovies()
    }

    handleCategoryClick(event) {
        this._selectedCategory = event.target.dataset.category;
        this._filterMovies()
    }

    clearSearch() {
        this.template.querySelector('[data-id="search-input"]').value = ''
        this._searchText = ''
        this._filterMovies()
    }
    _filterMovies(){
        console.log(this._searchText)
        console.log(this._selectedCategory)
        console.log("================")
        // filtering movies by text
        let __filteredMovies = this.allMovies.filter(movie => movie.Name.toLowerCase().includes(this._searchText.toLowerCase()))
        // filtering movies by category
        if (this._selectedCategory !== this.allCategories ){
            __filteredMovies = __filteredMovies.filter(movie => movie.Category__c === this._selectedCategory)
            this._previousCategory = this._selectedCategory
        }
        // passing the filtered movies Ids to the parent component
        this.dispatchEvent(new CustomEvent('movieidsfiltered', {detail: __filteredMovies}))
    }
}