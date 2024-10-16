(*A social network is a social structure made of individuals (or organizations) called nodes, which are tied (connected) by one or more specific types of interdependency, such as friendship, kinship, financial exchange, dislike, sexual relationships, or relationships of beliefs, knowledge or prestige.

A graph is an abstract representation of a set of objects where some pairs of the objects are connected by links. The interconnected objects are represented by mathematical abstractions called vertices, and the links that connect some pairs of vertices are called edges.

The exercise consists of:

implementing the social network as a graph, i.e., to define the graph data structure with the operations you consider necessary to implement a social network*)
type node = Individual of string | Organization of string;;
type interdependency = Friendship | Kinship | FinancialExchange | Dislike | SexualRelationship | Belief | Knowledge | Prestige;;
type edge = (node * node * interdependency);;

module type GraphInt = sig
  type 'a graph
  val empty : unit -> 'a graph
  
  val is_empty : 'a graph -> bool
  
  val add_node : 'a graph -> 'a -> 'a graph
  (*
  val add_edge : 'a graph -> 'a -> 'a -> 'a graph
  (*
  val remove_node : 'a graph -> 'a -> 'a graph
  (*
  val remove_edge : 'a graph -> 'a -> 'a -> 'a graph
  *)*)*)
end;;

module Graph:GraphInt = struct
  type 'a graph = Graph of (edge) list
  let empty() = Graph []
  let is_empty = function
    | Graph [] -> true
    | _ -> false
  let add_node g n = Graph (n::g.contents) 
  (*let add_edge g n1 n2 = edge (Individual n1, Individual n2, Friendship)::g*)
end;;

let () =
  let g = Graph.empty () in
  Printf.printf "Is the graph empty? %b\n" (Graph.is_empty g);;