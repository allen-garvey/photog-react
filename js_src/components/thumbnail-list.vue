<template>
    <main class="main container">
        <h2 v-if="model.name">{{model.name}}</h2>
        <ul class="album-list thumbnail-list">
            <li v-for="(item, i) in thumbnailList" :key="i">
                <router-link :to="showRouteFor(item)" class="image-container">
                    <img :alt="altTextFor(item)" :src="thumbnailUrlFor(item)" />
                </router-link>
                <h3 class="album-title" :class="{'default-title': !('name' in item)}"><router-link :to="showRouteFor(item)">{{titleFor(item)}}</router-link></h3>
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
        itemShowRouteName: {
            type: String,
            required: true,
        },
        thumbnailListKey: {
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
            //need this property or there will be errors when we switch routes and new models haven't been loaded yet
            isLoadingModel: true,
        }
    },
    computed: {
        thumbnailList: function(){
            if(this.isLoadingModel){
                return [];
            }
            if(this.thumbnailListKey){
                return this.model[this.thumbnailListKey];
            }
            return this.model;
        },
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
            this.isLoadingModel = true;
            this.getModel(modelPath).then((itemsJson)=>{
                this.model = itemsJson;
                this.isLoadingModel = false;
            });
        },
        thumbnailUrlFor: function(item){
            const imageContainer = item.cover_image ? item.cover_image : item;
            return `/media/thumbnails/${encodeURI(imageContainer.mini_thumbnail_path)}`;
        },
        showRouteFor: function(item){
            return {
                name: this.itemShowRouteName,
                params: {
                    id: item.id,
                },
            };
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
