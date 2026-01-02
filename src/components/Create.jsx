import React, { useState } from 'react';

function Create({ addTodo }) {
  const [task, setTask] = useState('');

  const handleAdd = () => {
    if (!task.trim()) return;

    addTodo({
      _id: Date.now().toString(), 
      task: task,
      done: false,
    });

    setTask(''); 
  };

  return (
    <div>
      <input
        className="create_form_input"
        type="text"
        placeholder="Enter Task"
        value={task}
        onChange={(e) => setTask(e.target.value)}
      />

      <button
        className="create_form_button"
        type="button"
        onClick={handleAdd}
      >
        Add
      </button>
    </div>
  );
}

export default Create;
