<template>
    <div>
        <Photog-Header></Photog-Header>
        <router-view :get-items="get"></router-view>
        <Photog-Footer></Photog-Footer>
    </div>
</template>

<script>
import PhotogHeader from './header.vue'
import PhotogFooter from './footer.vue'

const API_URL_BASE = '/api';

export default {
    name: 'Photog-App',
    props: {
    },
    components: {
        'Photog-Header': PhotogHeader,
        'Photog-Footer': PhotogFooter,
    },
    data() {
        return {
            cache: new Map(),
        }
    },
    computed: {

    },
    created() {
    },
    methods: {
        get: function(modelPath){
            if(this.cache.has(modelPath)){
                return new Promise((resolve)=>{
                    resolve(this.cache.get(modelPath));
                });
            }
            return fetch(API_URL_BASE + modelPath).then((res)=>{
                return res.json();
            }).then((json)=>{
                const data = json.data;
                this.cache.set(modelPath, data);
                return data;
            });
        },
    }
}
</script>
