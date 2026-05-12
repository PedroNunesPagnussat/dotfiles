---
name: book-distiller
description: Distill knowledge from a book or a specific chapter into a structured, applicable breakdown. Use whenever the user names a book or chapter and wants to understand the key ideas, mental models, frameworks, or how to apply the content to their life or work. Trigger phrases include "break down [book]", "distill [chapter]", "what are the key ideas in [book]", "help me extract knowledge from [book]", "summarize chapter X of [book]", or any variant where the user wants to internalize and act on book content rather than just get a generic summary. Use this even when the user only provides a title with no further instruction, since the skill exists to handle that exact case well.
---

# Book Distiller

Turn a book or chapter title into a structured, opinionated breakdown that surfaces the real ideas and makes them actionable.

This skill exists because generic book summaries are useless. They flatten interesting ideas into bullet points, skip counterpoints, and offer vague application advice ("try journaling!"). The goal here is the opposite: surface the actual argument, name the mental models explicitly, push back on weak parts, and force concrete application.

## Core workflow

### Step 1: Optional grounding

If the user uploaded a PDF or epub, read it. The uploaded text is ground truth.

If you don't have the text and want to firm up specifics (chapter titles, named frameworks, specific examples, critical reception for the counterpoints section), web search is fair game. Use it when it would meaningfully improve the breakdown, skip it when you have a solid grasp of the book already. Don't search out of habit, search when it adds value.

The user knows the breakdown is coming from your knowledge of the book and will judge it against the actual text. No need for confidence disclaimers.

### Step 2: Produce the breakdown

Use the structure below. Sections are flexible: expand them when the material is rich, drop optional ones when they don't apply, group concepts when there are many. The structure is a guide, not a cage.

#### Required sections

**Context**
One short paragraph: what kind of book this is, who it's written for, where it sits in its field. If the user named a chapter, briefly note how it fits in the larger book when relevant. This grounds the rest.

**Core thesis**
The actual argument the book or chapter is making, in one paragraph. Not a list of topics covered, the argument. If you can't state the thesis in a paragraph, you don't understand it well enough yet, go back and think harder.

**Why this matters**
Why should the reader care about this book or topic at all? What does engaging with the material unlock, what problem does it solve, what does someone who internalizes this see or do that someone who hasn't can't? Answer this honestly: if the topic is niche or only matters to a specific audience, say so. If the book overpromises on its importance, push back. The point is to help the user decide whether the ideas earn the time to internalize them.

**Key concepts**
The ideas that do the real work. Use as many as the material warrants, no artificial cap. For dense technical chapters this might be 10+ concepts, group them with subheadings if so. For a thin self-help chapter it might be 3. Each concept gets a name, a brief explanation in plain language, and (where useful) an analogy or example. Avoid jargon-dumping: if the book uses a term, explain what it actually means.

**Counterpoints**
This section is mandatory. Where is the book weak, contested, oversold, or missing important nuance? What do critics say? Where does the evidence not support the strong version of the claim? If you can't think of any counterpoints, you haven't thought hard enough, every popular nonfiction book has critics. This is the section most summaries skip and it's the most valuable.

**Application**
How the user can actually use this. Adapt the shape to the material:
- For tactical books (habits, productivity, sales): concrete experiments with timeframes, "try this for two weeks"
- For conceptual books (philosophy, theory): how the framework changes how you see something, what it lets you notice that you couldn't before
- For technical books: where this knowledge fits into existing skills, what it unlocks, what to practice

Avoid generic advice. "Be more mindful" is not application. "When you catch yourself reaching for your phone, name the trigger out loud" is.

**Second-order effects**
If the user actually adopts these ideas, what changes downstream? Push past the obvious first effect. Useful angles:
- What does this make harder or foreclose later? (e.g., committing hard to one productivity system makes it harder to switch when context changes)
- What does it cost? Time, social capital, identity, optionality
- What does it enable that wasn't possible before? Compounding effects over months or years
- What's the failure mode if applied poorly or too aggressively?
- Who or what loses when this gets applied? (the answer is sometimes "nothing", but often there's a tradeoff worth naming)

This section is where you stop summarizing and start thinking. The book itself usually won't tell you these things, that's why it's valuable.

#### Optional sections (include when warranted)

**Mental models / frameworks**
When the book offers explicit named frameworks (e.g., Eisenhower Matrix, OODA loop, the four agreements), pull them out as their own section. Name them, explain what they do, show when to reach for them. Skip this section if the book is more narrative or argumentative without distinct frameworks.

**Connections**
When the book connects strongly to other well-known ideas, books, or thinkers, note the connections briefly. Helps the user place this in their existing knowledge. Skip when the connections are weak or forced.

### Step 3: Calibration questions

End the breakdown with as many questions as the application section actually needs sharpening on. A focused book might need one pointed question, a sprawling one might need more. These are not generic ("what are your goals?"), they are pointed at the specific book.

Examples:
- For a book on negotiation: "Are you negotiating mostly with your manager, with vendors, or in personal relationships? The tactics differ."
- For a book on focus: "What's your current biggest distraction, your phone, your own thoughts, or context-switching between tasks?"
- For a book on systems thinking: "Is there a specific system in your work or life you're trying to understand better right now?"

The user will answer some or all of these and you will refine the application section based on their answers.

## Tone and format

- Write in plain language. The user is smart, don't lecture, don't pad
- Use bullets, tables, analogies, code blocks, whatever fits the content. Don't force prose where structure helps
- No em-dashes, use commas, parentheses, colons, or two sentences instead
- Skip preambles like "Great choice!" or "This is a fascinating book"
- Length should match the depth of the material, not the genre. A dense chapter of a technical book might run long, but so might a dense chapter of a self-help book. A thin chapter is short regardless of genre
- When the book is weak or shallow, say so. Don't manufacture insight that isn't there

## Things to avoid

- Hagiography. The book is not perfect, find the weak parts
- Generic application advice. If your suggestion would apply to any book, it's not real application
- Bullet-point lobotomy. Some ideas need a paragraph, give them a paragraph
- Citing things you're not sure about. If you think an idea is from book X but aren't sure, flag it ("I think this builds on Y, verify before citing")