<template>
    <div>
        <Photog-Header></Photog-Header>
        <router-view></router-view>
        <Photog-Footer></Photog-Footer>
    </div>
</template>

<script>
import PhotogHeader from './header.vue'
import PhotogFooter from './footer.vue'

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

        }
    },
    computed: {

    },
    created() {
    },
    methods: {

    }
}
</script>
