var app = new Vue({
  el: "#app",
  data: {
    opened: false,
    list: null,
    tempList: null,
    search: '',
    selectedCategory: null,
    activeAnim: null // <- nueva variable para animación activa
  },
  methods: {
    setTempList: function(type) {
      for (let i = 0; i < this.list.length; i++) {
        if (this.list[i].label === type) {
          this.tempList = this.list[i].sub;
          this.selectedCategory = type;
          break;
        }
      }
    },
    makeAnimation: function(anim) {
      if (this.activeAnim && this.activeAnim.value === anim.value) {
        $.post('https://bk_emotes/clear', JSON.stringify({}))
        this.activeAnim = null;
      } else {
        $.post('https://bk_emotes/execute', JSON.stringify({ anim }))
        this.activeAnim = anim;
      }
    },
  },
  computed: {
    filteredItems: function() {
      if (!this.tempList) return []
      return this.tempList.filter((anim) =>
        anim.label.toLowerCase().indexOf(this.search.toLowerCase()) > -1
      );
    },
  },
  mounted() {
    window.addEventListener('message', function(event) {
      if (event.data.action == 'open') {
        app.opened = true;
        app.list = event.data.list;
        app.tempList = event.data.list[0].sub;
        app.selectedCategory = event.data.list[0].label;
      }
    });

    document.onkeyup = function(data) {
      if (data.which == 27) {
        $.post('https://bk_emotes/exit', JSON.stringify({}));
        app.opened = false;
        return;
      }
    };

    // 👇 Cerrar el menú al hacer clic fuera
    document.addEventListener('mousedown', function (event) {
      if (app.opened) {
        const container = document.querySelector('.container');
        if (container && !container.contains(event.target)) {
          $.post('https://bk_emotes/exit', JSON.stringify({}));
          app.opened = false;
          return;
        }
      }
    });
  }
});
