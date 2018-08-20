<template>
    <main class="main container" v-if="isModelLoaded">
        <div class="album-image-show-header" v-if="parent">
            <router-link :to="{name: parent.parentRouteName, params: {id: model.id}}">Back to {{model.name}}</router-link>
            <div class="album-image-nav">
                <router-link :to="parent.showRouteFor(previousImage)" v-if="previousImage">Previous</router-link>
                <div v-if="!previousImage"></div>
                <router-link :to="parent.showRouteFor(nextImage)" v-if="nextImage">Next</router-link>
            </div>
            <div class="album-image-nav-previews">
                <ul class="image-preview-list">
                    <li :class="{'current-image': image.id === parent.modelId}" v-for="(image, i) in model.images" :key="i">
                        <router-link :to="parent.showRouteFor(image)" class="preview-container">
                            <img :src="thumbnailUrlFor(image.mini_thumbnail_path)">
                        </router-link>
                    </li>
                </ul>
            </div>
        </div>
        <div class="image-show-thumbnail-container">
            <a :href="masterUrl">
                <img :src="thumbnailUrlFor(image.thumbnail_path)"/>
            </a>
        </div>
        <div class="image-show-link-container">
            <a :href="masterUrl">View full-size</a>
        </div>
        <div class="image-show-info-section">
            <h3 class="Info"></h3>
            <dl>
                <dt>Date Taken</dt>
                <dd>{{image.creation_time.formatted.us_date}} {{image.creation_time.formatted.time}}</dd>
                <dt>Favorite</dt>
                <dd>{{image.is_favorite ? 'true' : 'false'}}</dd>
            </dl>
        </div>
    </main>
</template>

<script>
export default {
    name: 'Image-Detail',
    props: {
        getModel: {
            type: Function,
            required: true,
        },
        modelApiPath: {
            type: String,
            required: true,
        },
        parent: {
            type: Object,
        },
    },
    created(){
        //initial setup of items, since $route watch method won't be called on initial load
        this.loadModel(this.modelApiPath);
    },
    data() {
        return {
            model: null,
            imageModel: null, //for when the model is the parent of the image
            modelIndex: -1, //when model is parent, the index of the current image in the image array
        }
    },
    computed: {
        isModelLoaded: function(){
            return this.model && this.image;
        },
        masterUrl: function(){
            return this.generateImageUrl(this.image.master_path);
        },
        image: function(){
            if(this.parent){
                return this.imageModel;
            }
            return this.model;
        },
        previousImage: function(){
            if(!this.parent || this.modelIndex < 0 || this.modelIndex === 0){
                return null;
            }
            return this.model.images[this.modelIndex-1];
        },
        nextImage: function(){
            if(!this.parent || this.modelIndex < 0 || this.model.images.length <= this.modelIndex){
                return null;
            }
            return this.model.images[this.modelIndex+1];
        },
    },
    watch: {
        '$route'(to, from){
            this.loadModel(this.modelApiPath);
        }
    },
    methods: {
        loadModel: function(modelPath){
            this.imageModel = null;
            this.modelIndex = -1;
            this.getModel(modelPath).then((itemsJson)=>{
                this.model = itemsJson;
                
                //if parent, lookup image in parent images
                if(this.parent){
                    const imageId = this.parent.modelId;
                    for(let i=0;i<this.model.images.length;i++){
                        const image = this.model.images[i];
                        if(image.id === this.parent.modelId){
                            this.imageModel = image;
                            this.modelIndex = i;
                            break;
                        }
                    }
                }

            });
        },
        thumbnailUrlFor: function(thumbnailPath){
            return `/media/thumbnails/${encodeURI(thumbnailPath)}`;
        },
        generateImageUrl: function(rawUrl){
            return `/media/images/${encodeURI(rawUrl)}`;
        },
    }
}
</script>
