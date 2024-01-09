var addQuestionDialog = document.getElementById('add-question-dialog');
var addQuestionBtn = document.getElementById('add-question-btn');

addQuestionBtn.addEventListener('click', () => {
    console.log('test');
    addQuestionDialog.showModal();
})
