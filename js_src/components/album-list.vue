<template>
    <main class="main container">
        <ul class="album-list thumbnail-list">
            <li v-for="(item, i) in items" :key="i">
                <a href="/albums/3600" class="image-container">
                    <img :alt="`Thumbnail for ${item.name}`" :src="thumbnailUrlFor(item)" />
                </a>
                <h3 class="album-title"><a href="/albums/3600">{{item.name}}</a></h3>
            </li>
        </ul>
    </main>
</template>

<script>
export default {
    name: 'Album-List',
    props: {
        getItems: {
            type: Function,
            required: true,
        },
    },
    components: {
    },
    created(){
        //initial setup of items, since $route watch method won't be called on initial load
        console.log('album list created');
        console.log(this.$route);
        this.loadItems(this.$route.path);
    },
    data() {
        return {
            items: [],
        }
    },
    computed: {

    },
    watch: {
        '$route'(to, from){
            console.log('route changed');
            console.log(to);
            this.getItems(to.path);
        }
    },
    methods: {
        loadItems: function(modelPath){
            this.getItems(modelPath).then((itemsJson)=>{
                this.items = itemsJson;
            });
        },
        thumbnailUrlFor: function(item){
            return `/media/thumbnails/${encodeURI(item.cover_image.mini_thumbnail_path)}`;
        },
    }
}
</script>
