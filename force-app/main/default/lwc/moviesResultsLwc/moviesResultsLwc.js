/**
 * Created by yrazaq on 2/10/2022.
 */

import {api, LightningElement} from 'lwc';


export default class MoviesResultsLwc extends LightningElement {
    @api movies;

    handleMovieClick(event) {
        this.dispatchEvent(new CustomEvent('movieidseleceted', {detail: event.target.dataset.movieId}))
    }

}