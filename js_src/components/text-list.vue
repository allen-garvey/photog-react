<template>
    <main class="main container">
        <h2 v-if="model.name">{{model.name}}</h2>
        <ul class="text-list">
            <li v-for="(item, i) in thumbnailList" :key="i">
                <router-link :to="showRouteFor(item)">
                    {{titleFor(item)}}
                </router-link>
            </li>
        </ul>
    </main>
</template>

<script>
export default {
    name: 'Text-List',
    props: {
        getModel: {
            type: Function,
            required: true,
        },
        itemShowRouteName: {
            type: String,
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
            if(this.itemsListKey){
                return this.model[this.itemsListKey];
            }
            return this.model;
        },
    },
    watch: {
        '$route'(to, from){
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
    }
}
</script>
