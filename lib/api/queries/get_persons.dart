// const getPerson = r'''
//   query GetJobs() {
//     jobs {
//       id,
//       title,
//       locationNames,
//       isFeatured
//     }
//   }
// ''';
const getPerson = r"""
  query {
      persons{
        id, 
        name, 
        lastName, 
        age}
  }
""";
