<template>
    <header class="header container">
        <h1 class="brand"><a href="/">Photog</a></h1>
        <nav>
            <ul class="nav-list">
                <li><router-link to="/albums">Albums</router-link></li>
                <li><a href="/folders">Folders</a></li>
                <li><a href="/people">People</a></li>
            </ul>
        </nav>
    </header>
</template>

<script>
export default {
    name: 'Photog-Header',
    props: {

    },
    components: {
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
