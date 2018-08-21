<template>
    <main class="main container">
        <h2 v-if="model.name">{{model.name}}</h2>
        <ul class="thumbnail-list">
            <li v-for="(item, i) in thumbnailList" :key="i">
                <router-link :to="showRouteFor(item)" class="thumbnail-image-container">
                    <img :alt="altTextFor(item)" :src="thumbnailUrlFor(item)" />
                    <div v-if="isThumbnailFavorited(item)" class="heart"></div>
                </router-link>
                <h3 class="thumbnail-title" :class="{'default-title': !('name' in item)}"><router-link :to="showRouteFor(item)">{{titleFor(item)}}</router-link></h3>
            </li>
        </ul>
    </main>
</template>

<script>
export default {
    name: 'Thumbnail-List',
    props: {
        getModel: {
            type: Function,
            required: true,
        },
        showRouteFor: {
            type: Function,
            required: true,
        },
        itemsListKey: {
            type: String,
        },
    },
    components: {
    },
    created(){
        //initial setup of items, since $route watch method won't be called on initial load
        console.log('album list created');
        console.log(this.$route);
        this.loadModel(this.$route.path);
    },
    data() {
        return {
            model: [],
            thumbnailList: [],
        }
    },
    computed: {
    },
    watch: {
        '$route'(to, from){
            console.log('route changed');
            console.log(to);
            this.loadModel(to.path);
        }
    },
    methods: {
        loadModel: function(modelPath){
            this.thumbnailList = [];
            this.getModel(modelPath).then((itemsJson)=>{
                this.model = itemsJson;
                if(this.itemsListKey){
                    this.thumbnailList = this.model[this.itemsListKey];
                }
                else{
                    this.thumbnailList = this.model;
                }
            });
        },
        imageFor: function(item){
            if('cover_image' in item){
                return item.cover_image;
            }
            return item;
        },
        isThumbnailFavorited: function(item){
            //don't show favorite heart for cover image
            if('cover_image' in item){
                return false;
            }
            return this.imageFor(item).is_favorite;
        },
        thumbnailUrlFor: function(item){
            return `/media/thumbnails/${encodeURI(this.imageFor(item).mini_thumbnail_path)}`;
        },
        titleFor: function(item){
            if('name' in item){
                return item.name;
            }
            return `${item.creation_time.formatted.us_date} ${item.creation_time.formatted.time}`;
        },
        altTextFor: function(item){
            if('name' in item){
                return `Thumbnail for ${item.name}`;
            }
            return `Thumbnail for image taken on ${item.creation_time.formatted.us_date}`;
        },
    }
}
</script>
