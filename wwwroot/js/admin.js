var addUserDialog = document.getElementById("add-user-diag");
var addUserBtn = document.getElementById("add-user-btn");
var addCancelButton = document.getElementById("add-user-cancel");

addUserBtn.addEventListener('click', () => {
    addUserDialog.showModal();
})

addCancelButton.addEventListener('click', () => {
    addUserDialog.close();
});

var editUserDialog = document.getElementById("edit-user-diag");
var editUserBtn = document.getElementById('edit-user-btn');
var deleteUserBtn = document.getElementById('delete-user-btn');
var editCancelButton = document.getElementById('edit-user-cancel');
var editform = document.getElementById("edit-form");

/*
editUserBtn.addEventListener('click', () => {
    $.ajax({
        url: "/Admin?handler=GetSelectedUserById",
        type: "POST",
        data: { id: userId },
    }).done(function () {
        editUserDialog.showModal();
    })
})
*/

editUserBtn.addEventListener('click', function () {
    $.ajax({
        url: '/Admin?handler=ReturnUser',
        method: 'GET',
        data: { id: userId },
        success: function (user) {
            document.getElementById('edit-id').value = user.id;
            document.getElementById('edit-fname').value = user.firstName;
            document.getElementById('edit-lname').value = user.lastName;
            document.getElementById('edit-email').value = user.email;
            document.getElementById('edit-pass').value = user.password;
            document.getElementById('edit-school').value = user.school;
            document.getElementById('edit-speciality').value = user.speciality;
            document.getElementById('edit-isadmin').checked = (user.isAdmin === "True");
            console.log(user);
            editUserDialog.showModal();
        }
    })
})

editCancelButton.addEventListener('click', () => {
    editUserDialog.close();
})

//
var userId = 0;

checkId();

function checkId() {
    if (userId == 0) {
        editUserBtn.disabled = true;
        deleteUserBtn.disabled = true;
    }
    else {
        editUserBtn.disabled = false;
        deleteUserBtn.disabled = false;
    }
}

var rows = document.getElementsByClassName("rows");
for (var i = 0; i < rows.length; i++) {
    rows[i].addEventListener('click', function () {
        const rb = this.querySelector('input[name="user-rb"]');
        rb.checked = true;
        userId = rb.value;
        rb.focus();
        checkId();
        const radBtns = document.getElementsByName("user-rb");
        for (var j = 0; j < radBtns.length; j++) {
            if (radBtns[j].checked == true) {
                rows[j].style.backgroundColor = "#edf2f7";
            }
            else {
                rows[j].style.backgroundColor = "white";
            }
        }
    })
}

//
deleteUserBtn.addEventListener('click', function () {
    $.ajax({
        url: "/Admin?handler=DeleteUser",
        type: "POST",
        data: { id: userId }
    }).done(function () {
        location.replace("/Admin");
    })
})

var isAdminCheckboxes = document.querySelectorAll('.checkbox-isadmin');
isAdminCheckboxes.forEach(function (checkbox) {
    console.log(checkbox);
    checkbox.addEventListener('click', function (event) {
        event.preventDefault();
    })
})
