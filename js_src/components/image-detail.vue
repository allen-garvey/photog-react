<template>
    <main class="main container" v-if="isModelLoaded">
       <div class="image-show-thumbnail-container">
           <a :href="masterUrl">
               <img :src="thumbnailUrl"/>
           </a>
       </div>
        <div class="image-show-link-container">
            <a :href="masterUrl">View full-size</a>
        </div>
        <div class="image-show-info-section">
            <h3 class="Info"></h3>
            <dl>
                <dt>Date Taken</dt>
                <dd>{{model.creation_time.formatted.us_date}} {{model.creation_time.formatted.time}}</dd>
                <dt>Favorite</dt>
                <dd>{{model.is_favorite ? 'true' : 'false'}}</dd>
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
        }
    },
    computed: {
        isModelLoaded: function(){
            return !!this.model;
        },
        thumbnailUrl: function(){
            return this.generateImageUrl(this.model.thumbnail_path);
        },
        masterUrl: function(){
            return this.generateImageUrl(this.model.master_path, false);
        },
    },
    watch: {
        '$route'(to, from){
            this.loadModel(this.modelApiPath);
        }
    },
    methods: {
        loadModel: function(modelPath){
            this.getModel(modelPath).then((itemsJson)=>{
                this.model = itemsJson;
            });
        }, 
        generateImageUrl: function(rawUrl, isThumbnail=true){
            const imagePath = isThumbnail ? 'thumbnails' : 'images';
            return `/media/${imagePath}/${encodeURI(rawUrl)}`;
        },
    }
}
</script>
