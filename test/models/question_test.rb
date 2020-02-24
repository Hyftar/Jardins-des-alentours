require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "should be able to add tag to questions" do
    q = Question.create(
      title: 'R tomato fruit?',
      content: 'i wonderz',
      user: users(:one),
      community: communities(:montreal_tomatoes)
    )

    t1 = Tag.create(
      name: 'Tomato'
    )

    q.tags << t1

    assert_equal 1, q.tags.size
    assert_equal t1, q.tags.first

    t2 = Tag.create(
      name: 'Fruit'
    )

    q.tags << t2

    assert_equal 2, q.tags.size
    assert_equal t2, q.tags.last

    assert q.valid?
    assert q.save
  end

  test "should be able to use all the answer tags" do
    q = Question.create(
      title: 'R tomato fruit?',
      content: 'i wonderz',
      user: users(:one),
      community: communities(:montreal_tomatoes)
    )

    a = Answer.create(
      question: q,
      user: users(:two),
      content: 'Yes.'
    )

    assert a.active?

    a.removed!
    assert a.removed?

    a.deleted!
    assert a.deleted?
  end

  test "should be able to use all the question tags" do
    q = Question.create(
      title: 'R tomato fruit?',
      content: 'i wonderz',
      user: users(:one),
      community: communities(:montreal_tomatoes)
    )

    assert q.opened?
    assert q.valid?

    q.pending!
    assert q.pending?
    assert q.valid?

    q.removed!
    assert q.removed?
    assert q.valid?

    q.deleted!
    assert q.deleted?
    assert q.valid?

    q.closed!
    assert q.closed?
    assert_not q.opened?

    assert q.valid?

    assert_raise do
      q.status = 10
    end

    assert_raise do
      q.status = :potato
    end
  end

  test "should be able to save question" do
    q = Question.create(
      title: 'R tomato fruit?',
      content: 'i wonderz',
      user: users(:one),
      community: communities(:montreal_tomatoes)
    )

    assert q.save
  end

  test "should not be able to assign answer if it's not a question's child" do
    q = Question.create(
      title: 'R tomato fruit?',
      content: 'i wonderz',
      user: users(:one),
      community: communities(:montreal_tomatoes)
    )
    q.selected_answer = answers(:one)

    assert_not q.save
  end

  test "should be able to assign answer if it's a question's child" do
    q = Question.create(
      title: 'R tomato fruit?',
      content: 'i wonderz',
      user: users(:one),
      community: communities(:montreal_tomatoes)
    )

    a = Answer.create(
      question: q,
      user: users(:two),
      content: 'Yes.'
    )

    assert a.save

    q.selected_answer = a

    assert q.save
  end
end
