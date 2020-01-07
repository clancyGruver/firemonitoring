<template>
	<div class="container-fluid">
        <div class="row">
        	<full-calendar defaultView="dayGridMonth" :plugins="calendarPlugins" :events="events" :locale="locale"/>
        </div>
	</div>
</template>

<script>
import FullCalendar from '@fullcalendar/vue'
import dayGridPlugin from '@fullcalendar/daygrid'
import ruLocale from '@fullcalendar/core/locales/ru';

export default{
    components:{
        FullCalendar
    },
    data() {
        return {
            events: [ // initial event data
                { title: 'Event Now', start: new Date() }
            ],
            calendarPlugins: [ dayGridPlugin ],
            locale: ruLocale
        }
    },
	mounted: function(){
        self = this;
        axios.post('/api/plans/reglament')
            .then(
                response => 
                    self.events = response.data.map(
                        event => { return {title: event.title, start: new Date(event.start.date)} }
                    )
            );
	}
}
</script>

<style lang='scss'>

@import '~@fullcalendar/core/main.css';
@import '~@fullcalendar/daygrid/main.css';

</style>