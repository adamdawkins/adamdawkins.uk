import frontmatter from 'front-matter'
import marked from 'marked'

const haikuQuery = (root, { id }) => {
  const file = Assets.getText(`haikus/${id}.md`) // eslint-disable-line no-undef
	const content = frontmatter(file)
  console.log(content)
	return {
		id: content.attributes.date,
		body: marked(content.body),
		date: content.attributes.date,
	}
}


export default {
	Query: {
		haiku: haikuQuery,
	},
}
