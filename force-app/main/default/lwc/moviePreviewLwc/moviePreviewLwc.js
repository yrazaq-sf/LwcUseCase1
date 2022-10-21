/**
 * Created by yrazaq on 2/10/2022.
 */

import {api, LightningElement} from 'lwc';
import DEFAULT_MOVIE_IMAGE from '@salesforce/resourceUrl/NetflixBlackLogo';

export default class MoviePreviewLwc extends LightningElement {
    @api
    movie
    defaultMovieImage = DEFAULT_MOVIE_IMAGE
    @api
    get name() {
        return this.movie.Name;
    }

}