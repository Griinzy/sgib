
var modal = document.getElementById("userModal");
var btn = document.getElementsByClassName("user-btn")[0];
btn.addEventListener("click", function () {
    modal.style.display = "block";
})

window.addEventListener("click", function (event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
})