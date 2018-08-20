import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './components/app.vue'
import AlbumList from './components/album-list.vue'


Vue.use(VueRouter);

const router = new VueRouter({
    mode: 'history',
    routes: [
        { path: '/albums', component: AlbumList },
    ],
});

new Vue({
    el: '#app',
    render: h => h(App),
    router,
});