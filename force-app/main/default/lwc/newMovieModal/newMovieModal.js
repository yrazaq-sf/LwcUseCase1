/**
 * Created by yrazaq on 2/10/2022.
 */

import {api, LightningElement} from 'lwc';
import MOVIE_OBJECT from '@salesforce/schema/Movie__c'
import MOVIE_NAME_FIELD from '@salesforce/schema/Movie__c.Name'
import MOVIE_CATEGORY_FIELD from '@salesforce/schema/Movie__c.Category__c'
import MOVIE_DESCRIPTION_FIELD from '@salesforce/schema/Movie__c.Description__c'
import MOVIE_IMAGEURL_FIELD from '@salesforce/schema/Movie__c.ImageUrl__c'
import MOVIE_RELEASEDATE_FIELD from '@salesforce/schema/Movie__c.ReleaseDate__c'
import MOVIE_ISRELEASED_FIELD from '@salesforce/schema/Movie__c.IsReleased__c'
import MOVIEACTOR_OBJECT from '@salesforce/schema/MovieActor__c'
import MOVIEACTOR_ACTOR_FIELD from '@salesforce/schema/MovieActor__c.Actor__c'
import insertMovies from '@salesforce/apex/moviesController.insertMovies';
import insertMovieActors from '@salesforce/apex/moviesController.insertMovieActors';


export default class NewMovieModal extends LightningElement {
    @api isOpenModal
    @api categories
    // Movie__c object and fields
    movieObject = MOVIE_OBJECT
    movieName = MOVIE_NAME_FIELD
    movieCategory = MOVIE_CATEGORY_FIELD
    movieDescription = MOVIE_DESCRIPTION_FIELD
    movieImageUrl = MOVIE_IMAGEURL_FIELD
    movieRealeaseDate = MOVIE_RELEASEDATE_FIELD
    movieIsReleased = MOVIE_ISRELEASED_FIELD
    // empty movie reocrd
    movieRecord = {
        Name : null,
        Category__c: null,
        ReleaseDate__c : null,
        Description__c : null,
        IsReleased__c : null
    }
    // MovieActor object and fields
    movieActorsObject = MOVIEACTOR_OBJECT
    actorField = MOVIEACTOR_ACTOR_FIELD
    // list of indexes for multiple actors lookups.
    // the view will iterate threw this array to know how much actor lookups should be shown
    // isLastIndex proprety is usefull for showing whether + (add actor) or - (remove actor) button
    @api actors = [
        {index: 1, isLastIndex:false, value: undefined},
        {index: 2, isLastIndex:false, value: undefined},
        {index: 3, isLastIndex:true, value: undefined}
        ]
    // adding a new actor loopkup by adding an actorIndex{id, isLastIndex}
    addActorIndex(){
        let _actors = []
        // filling new actorIndexes with isLastIndex set to FALSE
        this.actors.forEach(actorIndex=>{
            _actors.push({
                index: actorIndex.index,
                isLastIndex: false,
                value : actorIndex.value
            })
        })
        // addind a new actor index with isLastIndex set to TRUE
        let _newActor = {index: this.actors[this.actors.length-1].id + 1,
                        isLastIndex: true,
                        value: undefined
        }
        _actors.push(_newActor)
        // updating the original array
        this.actors = _actors
    }
    removeActorIndex(event){
        let _currentActorIndexId = event.target.dataset.actorIndex
        this.actors = this.actors.filter(actorIndex => !(actorIndex.index.toString() === _currentActorIndexId))
    }
    // changing value of changed actor
    handleActorChange(event){
        // adding the selected actor id as in the value property of actors array
        this.actors.find(actor=> (actor.index.toString() === event.target.dataset.actorIndex)).value = event.target.value
    }
    // changing value of movie record
    handleMovieFieldChange(event){
        let changedFieldName = event.target.fieldName
        let value = event.target.value
        switch (changedFieldName){
            case this.movieName.fieldApiName:
                this.movieRecord.Name = value
                break
            case this.movieCategory.fieldApiName:
                this.movieRecord.Category__c = value
                break
            case this.movieDescription.fieldApiName:
                this.movieRecord.Description__c = value
                break
            case this.movieRealeaseDate.fieldApiName:
                this.movieRecord.ReleaseDate__c = value
                break
            case this.movieIsReleased.fieldApiName:
                this.movieRecord.IsReleased__c = value
                break
            default:
                console.error(changedFieldName + ' doesn\'t match any field in '+this.movieObject)
        }
    }
    // saving movie and movieActors records
    handleSaveButton(){
        // inserting movie record with apex controller
        insertMovies({movies: [this.movieRecord]})
            .then(result => {
                let insertedMovie = result[0];
                console.log("Movie inserted : "+insertedMovie.Id);
                let _movieId = insertedMovie.Id
                _insertMovieActors(_movieId, this.actors)
            })
            .catch(error => {
                console.error(error)
            });

        // inserting movie actors records
        function _insertMovieActors(_movieId, _actors) {
            // preparing movieActors data
            let movieActors = []
            _actors.forEach(actor =>{
                if (actor.value != null){
                    movieActors.push({
                        Movie__c: _movieId,
                        Actor__c: actor.value
                    })
                }
            })

            // inserting movie actors with apex controller
            if (movieActors.length){
                insertMovieActors({movieActors: movieActors})
                    .then(result => {
                        console.log(movieActors.length + " movie actors inserted")
                        console.log(result);
                })
                    .catch(error => {
                        console.error(error)
                    });
            }

        }
    }
    // function to pop down the modal
    closeModal() {
        this.dispatchEvent(new Event('closemodal'));
    }
}