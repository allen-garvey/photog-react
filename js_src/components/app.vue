<template>
    <div>
        <Photog-Header></Photog-Header>
        <router-view :get-model="get" ref="routerView" :get-exif="getExif"></router-view>
        <Photog-Footer></Photog-Footer>
    </div>
</template>

<script>
import PhotogHeader from './header.vue'
import PhotogFooter from './footer.vue'
import CacheUtil from '../cache-util.js'

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
            exifCache: new Map(),
        }
    },
    computed: {

    },
    created() {
        window.addEventListener('keyup', (e)=>{
            const routerView = this.$refs.routerView;
            switch(e.keyCode){
                //arrow left
                case 37:
                    if(routerView.keyLeftAction){
                        routerView.keyLeftAction();
                    }
                    break;
                //arrow right
                case 39:
                    if(routerView.keyRightAction){
                        routerView.keyRightAction();
                    }
                    break;
            }
        });
    },
    methods: {
        get(modelPath){
            const apiUrl = API_URL_BASE + modelPath;
            return CacheUtil.fetchIntoCache(apiUrl, this.cache, apiUrl);
        },
        getExif(imageId){
            const apiUrl = `${API_URL_BASE}/images/${imageId}/exif`;
            return CacheUtil.fetchIntoCache(apiUrl, this.exifCache, imageId);
        },
    }
}
</script>
