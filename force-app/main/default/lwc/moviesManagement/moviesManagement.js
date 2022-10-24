/**
 * Created by yrazaq on 30/9/2022.
 */

import {api, LightningElement, wire} from 'lwc';
import getAllMovies from '@salesforce/apex/moviesController.getAllMovies';
import NETFLIX_BLACK_LOGO from '@salesforce/resourceUrl/NetflixBlackLogo';
import {getObjectInfo, getPicklistValues} from "lightning/uiObjectInfoApi";
import Category__c from '@salesforce/schema/Movie__c.Category__c';


export default class MoviesManagement extends LightningElement {
    moviesIconName = 'custom:custom100';
    _selectedMovieId = undefined;
    selectedMovie = undefined;
    @api isOpenModal = false
    @api categories
    @api movies
    @api allMovies
    // Retrieving available categories
    @wire(getObjectInfo, {objectApiName: 'Movie__c'})
    MovieObjectInfo

    @wire(getPicklistValues, {
        recordTypeId: '$MovieObjectInfo.data.defaultRecordTypeId',
        fieldApiName: Category__c
    })
    _categories({data}) {
        this.__categories = []
        if (data) {
            data.values.forEach(val => this.__categories.push(val.label));
            this.categories = this.__categories
        }
    }

    // Retrieving all movies
    @wire(getAllMovies)
    _allMovies({data}) {
        if (data) {
            this.allMovies = data
            this.movies = data;

        }
    }

    handleMovieIdSelected(evt) {
        this._selectedMovieId = evt.detail
        this.selectedMovie = this.allMovies.find(movie => movie.Id === this._selectedMovieId)
    }

    handleMovieIdsFiltered(event) {
        this.movies = event.detail
    }
    resetMoviesFilter(){
        this.movies = this.allMovies
    }

    handleNewMovieClick() {
        this.isOpenModal = true
    }

    closeModal() {
        this.isOpenModal = false
    }
}